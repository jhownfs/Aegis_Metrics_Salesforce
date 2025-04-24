public with sharing class AegisMetricsStaticResourcesSelector {
    
    public static list<StaticResource> getStaticResourcesByName(String name) {
        return [SELECT Id, Body 
                FROM StaticResource 
                WHERE NamespacePrefix = 'AegisMetrics'
                AND Name =: name
                AND Body != null
                WITH SECURITY_ENFORCED];
    }
}