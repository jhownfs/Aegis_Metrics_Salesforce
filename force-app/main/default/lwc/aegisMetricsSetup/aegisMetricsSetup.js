import { LightningElement } from 'lwc';
import setupEvent from '@salesforce/label/c.Aegis_Metrics_Setup_Events';
import defaultEvent from '@salesforce/label/c.Aegist_Metrics_Default_Events';
import toggleActive from '@salesforce/label/c.Aegis_Metrics_Toggle_Active';
import toggerInative from '@salesforce/label/c.Aegis_Metrics_Toggle_Inative';
import getMonitoringTypes from '@salesforce/apex/AegisMetricsServices.getMonitoringTypes';
import updateMonitoringTypes from '@salesforce/apex/AegisMetricsServices.updateEventTypes';

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
    // Update the local state   
    // Call Apex method to update the monitoring type status
    // You can implement the logic to call the Apex method here
    console.log(`Monitoring Type ID: ${monitoringTypeId}, Enabled: ${isEnabled}`);
  }

  async handleSave(eventType) {

   const eventTypeJson = JSON.stringify(eventType);
   console.log('Event Type JSON:', eventTypeJson);
   const eventUpdate = await updateMonitoringTypes({ jsonData: eventTypeJson });

    if (eventUpdate) {
        console.log('Event updated successfully:', eventUpdate);
      } else {
        console.error('Error updating event:', eventType);
      }
  }

}