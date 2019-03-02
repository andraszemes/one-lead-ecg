<?php

class File {

public function __construct($file, $dir) {
    $this->file = $file;
    $this->dir = $dir;
}

public function name() {
    return md5(time());
}

public function type() {
    return strtolower(pathinfo($this->file['name'], PATHINFO_EXTENSION));
}

private function path() {
    return $this->dir.$this->name().'.'.$this->type();
}

public function error() {
    return $this->file['error'];
}

public function exists() {
    return file_exists($this->path());
}

public function size() {
    return $this->file['size'];
}

public function upload() {
    if(move_uploaded_file($this->file['tmp_name'], $this->path())) {
        return true;
    }
    throw new Exception('Upload failed.');
}

}