public with sharing class AegisMetricsBatch implements Database.Batchable<SObject>, Database.AllowsCallouts {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(EventMonitoringTypesSelector.getEnabledToIngestEventMonitoring());
    }

    public void execute(Database.BatchableContext bc, List<Event_Monitoring_Type__mdt> scope) {

        // This method is called for each batch of records
        List<String> eventMonitoringTypeNames = new List<String>();
        for (Event_Monitoring_Type__mdt eventMonitoringType : scope) {
            eventMonitoringTypeNames.add(eventMonitoringType.MasterLabel);
        }

       list<Eventlogfile> eventLogFiles = EventLogFileSelector.getEventLogFiles(eventMonitoringTypeNames);

    }   

    public void finish(Database.BatchableContext bc) {
    }
}