<?php

class LogEntry()
{
    public function createLogEntry($e){
        $datetime = new DateTime();    
        $datetime-&gt;setTimezone(new DateTimeZone('IST'));    
        $logEntry = $datetime-&gt;format('Y/m/d H:i:s') . '/' . $e-&gt;getMessage(). '/' .        
            $e-&gt;getCode() . '/' .        
            $e-&gt;getFile() . '/' .        
            $e-&gt;getLine();   
        return $logEntry;
    }
}