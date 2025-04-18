public with sharing class AegisMetricsQueuebleMaster implements Queueable {

    public void execute(QueueableContext context) {
        
        list<Event_Monitoring_Type__mdt> eventMonitoringTypes = AegisMetricsEventMonitoringTypesSelector.getEnabledToIngestEventMonitoring();
        
        list<String> eventMonitoringTypeLabels = new List<String>();
        
        for( Event_Monitoring_Type__mdt eventMonitoringType : eventMonitoringTypes ) {
            eventMonitoringTypeLabels.add(eventMonitoringType.MasterLabel.deleteWhitespace());
        }

        // Get the event log files for the enabled event monitoring types
        list<Eventlogfile> eventLogFiles = AegisMetricsEventLogFileSelector.getEventLogFiles(eventMonitoringTypeLabels);

        if(eventLogFiles.isEmpty()) {
            // No event log files to process
            return;
        }
        // Enqueue the queueable job for each event log file
        for (Eventlogfile eventLogFile : eventLogFiles) {
            System.enqueueJob(new AegisMetricsQueuebleSlave(eventLogFile));
        }
    }
}