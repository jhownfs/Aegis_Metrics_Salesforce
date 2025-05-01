import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import uploadSampleData from '@salesforce/apex/AegisMetricsServices.uploadSampleData';
import getInsightExternalDataStatus from '@salesforce/apex/AegisMetricsServices.getInsightExternalDataStatus';

export default class AegisMetricsUploadSampleData extends LightningElement {

  @api eventName;
  @api  fieldsNames;
  @api  fieldsTypes;
  
  @track progress = 0;
  @track isLoading = false;
  pollingRequestId;
  progressRequestId;
  showCheckmark = false;
  hideProgressBar = false;

  disconnectedCallback() {  
      cancelAnimationFrame(this.pollingRequestId);
      cancelAnimationFrame(this.progressRequestId);
  }


  async handleUploadSampleData(event) {
    
    this.progress = 0;
    event.preventDefault();
    event.stopPropagation();


    const Event_Monitoring_Type__mdt = {
      MasterLabel: this.eventName,
      Log_File_Field_Names__c : this.fieldsNames,
      Log_File_Field_Types__c : this.fieldsTypes,
    };

    const response = uploadSampleData({ jsonData: JSON.stringify(Event_Monitoring_Type__mdt) });

    if(response){
      this.isLoading = true;
      this.dispatchEvent(new ShowToastEvent({
        title: 'Success',
        message: 'Data Uploaded Started',
        variant: 'success'
      }));
    
      this.startPolling();
      this.startProgress();
      
    } else {
        this.dispatchEvent(new ShowToastEvent({
          title: 'Error',
          message: 'Error Uploading Data',
          variant: 'error'
        }));
      }
  }

  startPolling() {
      this.pollJobStatus();
  }

  async pollJobStatus() {
      try {
          const status = await getInsightExternalDataStatus({ name: this.eventName });

          if (status === 'Completed') {
              this.progress = 100;
              this.finalizeProgress();
          } else if (this.isLoading) {
              setTimeout(() => {
                  this.pollJobStatus();
              }, 4000); 
          }
      } catch (error) {
          this.handlePollingError(error);
      }
  }

  finalizeProgress() {
      this.isLoading = false;
      cancelAnimationFrame(this.progressRequestId);
      window.setTimeout(() => {
        this.showCheckmark = true;
        this.isLoading = false;
      }, 10000);
  }

  handlePollingError(error) {
      console.error('Erro ao consultar status do job', error);
      this.isLoading = false;
      cancelAnimationFrame(this.progressRequestId);
      // Opcional: adicionar um toast de erro
      this.showErrorToast('Erro ao consultar status do job. Tente novamente.');
  }

  showErrorToast(message) {
      const event = new ShowToastEvent({
          title: 'Erro',
          message: message,
          variant: 'error',
      });
      this.dispatchEvent(event);
  }


  startProgress() {
      const animateProgress = () => {
        if (this.progress < 95 && this.isLoading) {
          this.progress += 0.1; 
        }
        this.progressRequestId = requestAnimationFrame(animateProgress);
      };

      this.progressRequestId = requestAnimationFrame(animateProgress);
  }

  get progressBarClass() {
      return this.progress === 100 ? 'completed-progress' : '';
  }

  get progressRoundedDisplay() {
    return `${Math.round(this.progress)}%`;
  }
}