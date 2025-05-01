import { LightningElement, track } from 'lwc';
import scheduleJob from '@salesforce/apex/AegisMetricsServices.scheduleJob';
import getNextExecutionTime from '@salesforce/apex/AegisMetricsServices.getNextExecutionTime';
import deleteJob from '@salesforce/apex/AegisMetricsServices.deleteJob';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { label } from 'c/aegisLabelUtility';


export default class AegisMetricsScheduler extends LightningElement {

  @track nextExecution;
  @track showModal = false;
  @track label = label;
  
  connectedCallback() {
    this.loadNextExecution();
  }

  async handleSchedule() {
    try {
      await scheduleJob();
      this.showToast('Sucesso', 'Classe agendada com sucesso!', 'success');
      this.loadNextExecution();
    } catch (err) {
      this.showToast('Erro', err.body.message, 'error');
    }
  }

  async loadNextExecution() {
    try {
      this.nextExecution = await getNextExecutionTime();
    } catch (err) {
      this.showToast('Erro', err.body.message, 'error');
    }
  }

  async handleDelete() {
    try {
      await deleteJob();
      this.showToast('Sucesso', 'Agendamento cancelado com sucesso!', 'success');
      this.nextExecution = null;
      this.showModal = false;
    } catch (err) {
      this.showToast('Error', err.body.message, 'error');
    }
  }

  
    showToast(title, message, variant) {
      this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }

    openModal() {
      this.showModal = true;
    }
  
    closeModal() {
      this.showModal = false;
    }

}