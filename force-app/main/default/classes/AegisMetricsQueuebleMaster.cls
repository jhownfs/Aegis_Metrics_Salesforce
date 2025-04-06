public with sharing class AegisMetricsQueuebleMaster implements Queueable {

    public void execute(QueueableContext context) {
        
        list<Event_Monitoring_Type__mdt> eventMonitoringTypes = EventMonitoringTypesSelector.getEnabledToIngestEventMonitoring();
        
        list<String> eventMonitoringTypeLabels = new List<String>();
        for( Event_Monitoring_Type__mdt eventMonitoringType : eventMonitoringTypes ) {
            eventMonitoringTypeLabels.add(eventMonitoringType.MasterLabel);
        }

        // Get the event log files for the enabled event monitoring types
        list<Eventlogfile> eventLogFiles = EventLogFileSelector.getEventLogFiles(eventMonitoringTypeLabels);

        // Enqueue the queueable job for each event log file
        for (Eventlogfile eventLogFile : eventLogFiles) {
            System.enqueueJob(new AegistMetricsQueuebleSlave(eventLogFile));
        }
    }
}