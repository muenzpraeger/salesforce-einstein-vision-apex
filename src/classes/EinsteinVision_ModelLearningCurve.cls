public class EinsteinVision_ModelLearningCurve {
    
    @AuraEnabled
    public Integer epoch {get; set;}
    @AuraEnabled
    public List<EinsteinVision_EpochResult> epochResults {get; set;}
    @AuraEnabled
    public EinsteinVision_ModelMetrics modelMetrics {get; set;}
    
}