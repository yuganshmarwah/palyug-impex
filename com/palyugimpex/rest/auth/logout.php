<?php

session_start();
unset($_SESSION['emailId'] );
unset($_SESSION['name'] );
unset($_SESSION['firm_name'] );
unset($_SESSION['line1'] );
unset($_SESSION['line2'] );
unset($_SESSION['line3'] );
unset($_SESSION['city'] );
unset($_SESSION['state'] );
unset($_SESSION['country'] );
unset($_SESSION['contact_no'] );
unset($_SESSION['tin_no'] );
unset($_SESSION['cin_no'] );
unset($_SESSION['gstin_no'] );
session_commit();
header("Location:Index.html");
