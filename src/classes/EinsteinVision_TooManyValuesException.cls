public class EinsteinVision_TooManyValuesException extends Exception {

    public EinsteinVision_TooManyValuesException(String field, Integer maxValue, Integer currentValue) {
        setMessage('The maximum allowed number of entries for "' + field + '" is ' + maxValue + ' (current: ' + currentValue + ').');
    }

}