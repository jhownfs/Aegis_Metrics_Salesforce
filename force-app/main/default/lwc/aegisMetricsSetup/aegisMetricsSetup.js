import { LightningElement } from 'lwc';
import setupEvent from '@salesforce/label/c.Aegis_Metrics_Setup_Events';
import defaultEvent from '@salesforce/label/c.Aegist_Metrics_Default_Events';
import toggleActive from '@salesforce/label/c.Aegis_Metrics_Toggle_Active';
import toggerInative from '@salesforce/label/c.Aegis_Metrics_Toggle_Inative';
import getMonitoringTypes from '@salesforce/apex/AegisMetricsServices.getMonitoringTypes';
import updateMonitoringTypes from '@salesforce/apex/AegisMetricsServices.updateEventTypes';
import successMessage from '@salesforce/label/c.Aegis_Metrics_Toast_Success_Message';
import errorMessage from '@salesforce/label/c.Aegis_Metrics_Toast_Error_Message';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class aegisMetricsSetup extends LightningElement {
 
  enabledMonitoringTypes;
  defaultMonitoringTypes;

  label = {
    setupEvent,
    defaultEvent,
    toggleActive,
    toggerInative
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

  handleToggle(event) {
    event.stopPropagation();
    event.preventDefault();
    const monitoringTypeId = event.target.value;
    const isEnabled = event.target.checked;

    const Event_Monitoring_Type__mdt = {
      Id: monitoringTypeId,
      Enabled_To_Ingest__c: isEnabled
    };

    this.handleSave(Event_Monitoring_Type__mdt);

  }

  async handleSave(eventType) {

   const eventTypeJson = JSON.stringify(eventType);
   const eventUpdate = await updateMonitoringTypes({ jsonData: eventTypeJson });

    if (eventUpdate) {
        this.showMessageToUser('Success', successMessage, 'success');
      } else {
        this.showMessageToUser('Error', errorMessage, 'error');
      }
  }

  async showMessageToUser(title, message, variant) {
    const event = new ShowToastEvent({
      title: title,
      message: message,
      variant: variant,
    });
    this.dispatchEvent(event);
  }
}