public with sharing class AegisMetricsServices {
 
    @AuraEnabled
    public static  list<Event_Monitoring_Type__mdt> getMonitoringTypes(){

        List<Event_Monitoring_Type__mdt> eventMonitoringTypes = new List<Event_Monitoring_Type__mdt>();

        try {
            
            eventMonitoringTypes = EventMonitoringTypesSelector.getAllEventMonitoringTypes();

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return eventMonitoringTypes;
    }
}