public with sharing class EinsteinVision_PlanData {
    
    @AuraEnabled
    private String plan {get; set;}
    @AuraEnabled
    private String source {get; set;}
    @AuraEnabled
    private Long amount {get; set;}
    
}