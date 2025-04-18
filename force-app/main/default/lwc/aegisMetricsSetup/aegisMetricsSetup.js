import { LightningElement } from 'lwc';
import setupEvent from '@salesforce/label/c.Aegis_Metrics_Setup_Events';
import defaultEvent from '@salesforce/label/c.Aegist_Metrics_Default_Events';
import getMonitoringTypes from '@salesforce/apex/AegisMetricsServices.getMonitoringTypes';

export default class aegisMetricsSetup extends LightningElement {
 
  enabledMonitoringTypes;
  defaultMonitoringTypes;

  label = {
    setupEvent,
    defaultEvent
  };

  async connectedCallback() {
    try {
      let MonitoringTypes = await getMonitoringTypes();
      this.defaultMonitoringTypes = MonitoringTypes.filter(type => type.Default_Event__c === true);
      this.enabledMonitoringTypes = MonitoringTypes.filter(type => type.Enabled_To_Admin__c === true);
    } catch (error) {
      console.error('Error fetching monitoring types:', error);
    }
  }
}