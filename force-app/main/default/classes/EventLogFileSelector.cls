public with sharing class EventLogFileSelector {

    public static list<Eventlogfile> getEventLogFiles(List<String> eventMonitoringTypeNames) {
        return [SELECT Id, LogFile, LogFileFieldNames, EventType
                FROM Eventlogfile 
                WHERE EventType IN : eventMonitoringTypeNames 
                WITH SECURITY_ENFORCED];
    }
}