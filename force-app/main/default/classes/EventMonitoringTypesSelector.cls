public with sharing class EventMonitoringTypesSelector {
    
    public static list<Event_Monitoring_Type__mdt> getAllEventMonitoringTypes() {
       return [SELECT MasterLabel, Enabled_To_Admin__c, Enabled_To_Ingest__c 
               FROM Event_Monitoring_Type__mdt 
               ORDER BY Event_Monitoring_Type_Name__c];
    }
}