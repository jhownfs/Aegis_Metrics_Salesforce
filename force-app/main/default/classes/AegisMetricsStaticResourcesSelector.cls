public with sharing class AegisMetricsStaticResourcesSelector {
    
    public static list<StaticResource> getStaticResourcesByName(String name) {
        return [SELECT Id, Body 
                FROM StaticResource 
                WHERE Name =: name
                WITH SECURITY_ENFORCED];
    }
}