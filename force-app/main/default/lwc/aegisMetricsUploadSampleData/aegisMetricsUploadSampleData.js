import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import uploadSampleData from '@salesforce/apex/AegisMetricsServices.uploadSampleData';

export default class AegisMetricsUploadSampleData extends LightningElement {

  @api eventName;
  @api  fieldsNames;
  @api  fieldsTypes;

  handleUploadSampleData() {

    const Event_Monitoring_Type__mdt = {
      MasterLabel: this.eventName,
      Log_File_Field_Names__c : this.fieldsNames,
      Log_File_Field_Types__c : this.fieldsTypes,
    };

    uploadSampleData({ jsonData: JSON.stringify(Event_Monitoring_Type__mdt) })

      .then(() => {
        this.dispatchEvent(new ShowToastEvent({
          title: 'Success',
          message: 'Data Uploaded Successfully',
          variant: 'success'
        }));
      })
      .catch(() => {
        this.dispatchEvent(new ShowToastEvent({
          title: 'Error',
          message: 'Error Uploading Data',
          variant: 'error'
        }));
      });
  }

}