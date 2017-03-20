public class EinsteinVision_NumberToSmallException extends Exception {
    
    public EinsteinVision_NumberToSmallException (String field, Integer minValue, Integer currentValue) {
        setMessage('The minimum allowed size for "' + field + '" is ' + minValue + ' (current: ' + currentValue + ').'); 
    }
    
    public EinsteinVision_NumberToSmallException (String field, Double minValue, Double currentValue) {
        setMessage('The minimum allowed size for "' + field + '" is ' + minValue + ' (current: ' + currentValue + ').'); 
    }

}