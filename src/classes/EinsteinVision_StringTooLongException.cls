public class EinsteinVision_StringTooLongException extends Exception {

    public EinsteinVision_StringTooLongException(String field, Integer maxValue, Integer currentValue) {
        setMessage('The maximum allowed length for "' + field + '" is ' + maxValue + ' (current: ' + currentValue + ').');
    }

}