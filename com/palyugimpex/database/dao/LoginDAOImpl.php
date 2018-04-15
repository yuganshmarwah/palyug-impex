<?php

class DbOperation
{
    private $con;
    private $logPath;
    private $logEntryObj;

    function __construct()
    {
        require_once dirname(__FILE__) . '../base/DbConnect.php';
        require_once dirname(__FILE__) . '../../exception/DAOException.php'
        $db = new DbConnect();
        $this->logEntryObj = new LogEntry();
        $this->con = $db->connect();
        $this->logPath = dirname(__FILE__) . '../logs'
    }

    //Method to add a new user
    public function createUserLogin($login){
        try{
            $email_id = $login->getEmailId();
            $password = $login->password();
            $role_id = $login->getRoleId();
            $fl_flag = $login->getFlFlag();
            $status = $login->getStatus();
            if (!$this->isUserExists($emailId)) {
                $stmt = $this->con->prepare("INSERT INTO login(email_id, password, role_id, fl_flag, status) values(?, ?, ?, ?, ?)");
                $stmt->bind_param("ssiss", $email_id, $password, $role_id, $fl_flag, $status);
                $result = $stmt->execute();
                $stmt->close();
                if ($result) {
                    return 0;
                } else {
                    return 1;
                }
            } else {
                return 2;
            }
        }catch(Exception $e){
            $logEntry = $this->logEntryObj->createLogEnytry();
            // log to default error_log destination    
            error_log($logEntry,3,$this->logPath . '/error-' . $datetime-&gt;format('Y-m-d') . '.log');
        }
    }

    //Method to let a user log in
    public function userLogin($email_id, $password){
        try{
            $password = md5($pass);
            $stmt = $this->con->prepare("SELECT * FROM login WHERE email_id=? and password =?");
            $stmt->bind_param("ss",$email_id,$password);
            $stmt->execute();
            $stmt->store_result();
            $num_rows = $stmt->num_rows;
            $stmt->close();
            return $num_rows>0;
        }catch(Exception $e){
            $datetime = new DateTime();    
            $datetime-&gt;setTimezone(new DateTimeZone('IST'));    
            $logEntry = $datetime-&gt;format('Y/m/d H:i:s') . '/' . $e-&gt;getMessage(). '/' .        
                $e-&gt;getCode() . '/' .        
                $e-&gt;getFile() . '/' .        
                $e-&gt;getLine();   
            // log to default error_log destination    
            error_log($logEntry,3,$this->$logPath . '/error-' . $datetime-&gt;format('Y-m-d') . '.log');
        }
    }

    //Method to check whether a user exists or not
    public function isUserExists($email_id){
        try{
            $stmt = $this->$con->prepare("SELECT * FROM login WHERE email_id=?")
            $stmt->bind_param("s",$email_id)
            $stmt->execute();
            $stmt->store_result();
            $num_rows = $stmt->$num_rows;
            $stmt->close();
            return $num_rows>0;
        }catch(Exception $e){
            $datetime = new DateTime();    
            $datetime-&gt;setTimezone(new DateTimeZone('IST'));    
            $logEntry = $datetime-&gt;format('Y/m/d H:i:s') . '/' . $e-&gt;getMessage(). '/' .        
                $e-&gt;getCode() . '/' .        
                $e-&gt;getFile() . '/' .        
                $e-&gt;getLine();   
            // log to default error_log destination    
            error_log($logEntry,3,$this->$logPath . '/error-' . $datetime-&gt;format('Y-m-d') . '.log');   
        }
    }

}