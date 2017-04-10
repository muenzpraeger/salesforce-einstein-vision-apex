public with sharing class EinsteinVision_ApiUsage {
   
   @AuraEnabled 
   private long id {get; set;}
   @AuraEnabled
   private long organizationId {get; set;}
   @AuraEnabled
   private String startsAt {get; set;}
   @AuraEnabled
   private String endsAt {get; set;}
   @AuraEnabled
   private String licenseId {get; set;}
   @AuraEnabled
   private long predictionsMax {get; set;}
   @AuraEnabled
   private long predictionsRemaining {get; set;}
   @AuraEnabled
   private long predictionsUsed {get; set;}
   @AuraEnabled
   private EinsteinVision_PlanData[] planData {get; set;}
    
}