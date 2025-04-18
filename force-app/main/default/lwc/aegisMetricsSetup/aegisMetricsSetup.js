import { LightningElement } from 'lwc';
import setupEvent from '@salesforce/label/c.Aegis_Metrics_Setup_Events';
import defaultEvent from '@salesforce/label/c.Aegist_Metrics_Default_Events';
import GetMonitoringTypes from '@salesforce/apex/AegisMetricsServices.getMonitoringTypes';

export default class AegisMetricsSetup extends LightningElement {
 
  monitoringTypes;

  label = {
    setupEvent,
    defaultEvent
  };

  async connectedCallback() {
    try {
      //this.monitoringTypes = await GetMonitoringTypes();
      //console.log('Monitoring Types:', this.monitoringTypes);
    } catch (error) {
      console.error('Error fetching monitoring types:', error);
    }
  }
}