<?php

class LoginDAO
{
    private $emailId = Null;
    private $password = Null;
    private $roleId = Null;
    private $flFlag = Null;
    private $status = Null;

    public function getEmailId(){
        return $this->$emailId
    }

    public function setEmailId($emailId){
        $this->$emailId = $emailId
    }

    public function getPassword(){
        return $this->password
    }

    public function setPassword($password){
        $this->$password = $password
    }

    public function getRoleId(){
        return $this->$roleId
    }

    public function setRoleId($roleId){
        $this->$roleId = $roleId
    }

    public function getFlFlag(){
        return $this->$flFlag
    }

    public function setFlFlag($flFlag){
        $this->$flFlag = $flFlag
    }

    public function getStatus(){
        return $this->$status
    }

    public function setStatus($status){
        $this->$status = $status
    }
}