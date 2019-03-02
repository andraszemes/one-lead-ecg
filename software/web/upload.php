<?php

require_once("File.php");

if($_FILES['csv']) {

    $file = new File($_FILES['csv'], 'uploads/');

    if(!$file->error() && !$file->exists() && $file->type()=='csv' && $file->size()<2000000) {
        try {
            $file->upload();
            header('Location: /?f='.$file->name());
            exit;
        } catch(Exception $e) {
            die($e->getMessage());
        }
    }

    header('Location: /?error');
}