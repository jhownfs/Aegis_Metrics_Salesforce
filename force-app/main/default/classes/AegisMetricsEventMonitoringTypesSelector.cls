public with sharing class AegisMetricsEventMonitoringTypesSelector {
    
    public static list<Event_Monitoring_Type__mdt> getAllEventMonitoringTypes() {
       return [SELECT Id, MasterLabel, Enabled_To_Admin__c, Enabled_To_Ingest__c, Default_Event__c, 
               Log_File_Field_Names__c, Log_File_Field_Types__c
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

    public static list<Event_Monitoring_Type__mdt> getEventMonitoringTypeById( Id eventMonitoringTypeId) {
        return [SELECT MasterLabel,  Enabled_To_Ingest__c, DeveloperName
                FROM Event_Monitoring_Type__mdt
                WHERE Default_Event__c = false
                AND Id =: eventMonitoringTypeId
                WITH SECURITY_ENFORCED
                ];
    }
}