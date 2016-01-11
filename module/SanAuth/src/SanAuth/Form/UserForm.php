<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace SanAuth\Form;

use Zend\Form\Form;

class UserForm extends Form {

    public function __construct($name = null) {
        // we want to ignore the name passed
        parent::__construct('users');

      
        $this->add(array(
            'name' => 'user_name',
            'type' => 'Text',
            'options' => array(
                'label' => 'user name',
            ),
        ));
        $this->add(array(
            'name' => 'pass_word',
            'type' => 'password',
            'options' => array(
                'label' => 'pass word',
            ),
        ));
        $this->add(array(
            'name' => 'submit',
            'type' => 'Submit',
            'attributes' => array(
                'value' => 'log in',
                'id' => 'submitbutton',
            ),
        ));
    }

}
