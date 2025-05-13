import setupEvent from '@salesforce/label/c.Aegis_Metrics_Setup_Events';
import defaultEvent from '@salesforce/label/c.Aegist_Metrics_Default_Events';
import toggleActive from '@salesforce/label/c.Aegis_Metrics_Toggle_Active';
import toggerInative from '@salesforce/label/c.Aegis_Metrics_Toggle_Inative';
import schedulerHeader from '@salesforce/label/c.Aegis_Metrics_Scheduler_Header';
import schedulerButtonLabel from '@salesforce/label/c.Aegis_Metrics_Scheduler_Button_Label';
import schedulerCancelButtonLabel from '@salesforce/label/c.Aegis_Metrics_Cancel_Button_Label';
import nextExecutionLabel from '@salesforce/label/c.Aegis_Metrics_Next_Execution_Label'; 
import schedulerConfirmCancelHeader from '@salesforce/label/c.Aegis_Metrics_Cancel_Scheduler_Modal_Header'; 
import schedulerConfirmCancelBody from '@salesforce/label/c.Aegis_Metrics_Cancel_Scheduler_Modal_Body';
import schedulerCancelModalButtonCancelLabel from '@salesforce/label/c.Aegis_Metrics_Cancel_Scheduler_Modal_Button_Cancel_Label';
import schedulerCancelModalButtonConfirmLabel from '@salesforce/label/c.Aegis_Metrics_Cancel_Scheduler_Modal_Button_Confirm_Label'; 
import schedulerRemindeExecutionLabel from '@salesforce/label/c.Aegis_Metrics_Remider_Scheduler_Execution';

 const label = {
    setupEvent,
    defaultEvent,
    toggleActive,
    toggerInative,
    schedulerHeader,
    schedulerButtonLabel,
    schedulerCancelButtonLabel,
    nextExecutionLabel,
    schedulerConfirmCancelHeader,
    schedulerConfirmCancelBody,
    schedulerCancelModalButtonCancelLabel,
    schedulerCancelModalButtonConfirmLabel,
    schedulerRemindeExecutionLabel
  };

export {label};