import { LightningElement, track } from 'lwc';
import scheduleJob from '@salesforce/apex/AegisMetricsServices.scheduleJob';
import getNextExecutionTime from '@salesforce/apex/AegisMetricsServices.getNextExecutionTime';
import deleteJob from '@salesforce/apex/AegisMetricsServices.deleteJob';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class AegisMetricsScheduler extends LightningElement {

  @track nextExecution;
  @track error;
  @track showModal = false;

  connectedCallback() {
    this.loadNextExecution();
  }

  async handleSchedule() {
    try {
      await scheduleJob();
      this.loadNextExecution();
    } catch (err) {
      this.error = 'Erro ao agendar a classe.';
      console.error(err);
    }
  }

  async loadNextExecution() {
    try {
      this.nextExecution = await getNextExecutionTime();
      this.showToast('Sucesso', 'Classe agendada com sucesso!', 'success');
      this.error = null;
    } catch (err) {
      this.showToast('Erro', 'Erro ao agendar a classe.', 'error');
      this.error = 'Erro ao buscar próxima execução.';
      console.error(err);
    }
  }

  async handleDelete() {
    try {
      await deleteJob();
      this.showToast('Sucesso', 'Agendamento cancelado com sucesso!', 'success');
      this.nextExecution = null;
      this.showModal = false;
    } catch (err) {
      this.showToast('Erro', 'Erro ao cancelar o agendamento.', 'error');
      console.error(err);
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