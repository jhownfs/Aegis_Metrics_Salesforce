public with sharing class AegisMetricsServices {
 

    @AuraEnabled
    public static  list<Event_Monitoring_Type__mdt> getMonitoringTypes(){

        List<Event_Monitoring_Type__mdt> eventMonitoringTypes = new List<Event_Monitoring_Type__mdt>();

        try {
            
            eventMonitoringTypes = AegisMetricsEventMonitoringTypesSelector.getAllEventMonitoringTypes();

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return eventMonitoringTypes;
    }

    @AuraEnabled
    public static Boolean updateEventTypes(List<Event_Monitoring_Type__mdt> eventMonitoringTypes){

        List<Eventlogfile> eventLogFiles = new List<Eventlogfile>();
        Boolean isSuccess = false;
        try {


        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return isSuccess;
    }
}