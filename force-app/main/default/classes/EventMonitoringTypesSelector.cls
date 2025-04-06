public with sharing class EventMonitoringTypesSelector {
    
    public static list<Event_Monitoring_Type__mdt> getAllEventMonitoringTypes() {
       return [SELECT MasterLabel, Enabled_To_Admin__c, Enabled_To_Ingest__c 
               FROM Event_Monitoring_Type__mdt 
               WITH SECURITY_ENFORCED
               ORDER BY MasterLabel];
    }

    public static list<Event_Monitoring_Type__mdt> getEnabledToIngestEventMonitoring() {
        return [SELECT MasterLabel,  Enabled_To_Ingest__c 
                FROM Event_Monitoring_Type__mdt
                WHERE Enabled_To_Ingest__c = true 
                AND Default_Event__c = false
                WITH SECURITY_ENFORCED
                ORDER BY MasterLabel];
    }
}