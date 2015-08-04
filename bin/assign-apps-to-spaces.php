#!/usr/bin/env php
<?php

$assignments = array(
    1 => array(
        // reserved for browsers
    ),
    2 => array(
        'com.jetbrains.phpstorm',
        'com.jetbrains.phpstorm-eap',
        'com.jetbrains.pycharm',
    ),
    3 => array(
        'com.jetbrains.appcode',
        'com.jetbrains.intellij',
    ),
    4 => array(
        'com.skype.skype',
        'com.tinyspeck.slackmacgap',
        'com.codeux.irc.textual5.trial',
        'com.apple.ichat',
        'me.rsms.fbmessenger',
    ),
    5 => array(
        'com.apple.terminal',
    ),
    6 => array(
        'dia',
        'com.torusknot.sourcetreenotmas',
    ),
    7 => array(
        'com.apple.photos',
        'org.videolan.vlc',
        'com.apple.itunes',
        'com.spotify.client',
    ),
    8 => array(
        'com.apple.iwork.pages',
        'org.libreoffice.script',
        'com.apple.ical',
    ),
    9 => array(
        // reserved for browsers
    ),
    10 => array(
        'org.vim.macvim',
    ),
    11 => array(
        'com.apple.dt.xcode',
        'com.jetbrains.rubymine',
    ),
    12 => array(
        'com.apple.mail',
        'com.viber.osx',
    ),
    13 => array(
        // reserved for terminal
    ),
    14 => array(
        'com.postgresapp.postgres',
        'com.sequelpro.sequelpro',
    ),
    15 => array(
        'com.agilebits.onepassword4',
        'com.wunderkinder.wunderlistdesktop',
    ),
    16 => array(
        'com.apple.iwork.keynote',
        'com.apple.iwork.numbers',
        'org.m0k.transmission',
    ),
);


ob_start();
system('defaults read com.apple.spaces  | plutil -convert json - -o -');

$output = ob_get_contents();
ob_end_clean();

$data = json_decode($output, true);

$monitors = $data['SpacesDisplayConfiguration']['Management Data']['Monitors'];

$spacesUuids = array();
foreach ($monitors as $monitor) {
    $spaces = $monitor['Spaces'];

    foreach ($spaces as $space) {
        $spaceUuids[] = $space['uuid'];
    }
}

foreach ($spaceUuids as $i => $spaceUuid) {
    $spaceAssignments = $assignments[++$i];

    foreach ($spaceAssignments as $spaceAssignment) {
        $command = sprintf(
            'defaults write com.apple.spaces app-bindings -dict-add %s -string %s',
            $spaceAssignment,
            $spaceUuid
        );

        exec($command);
    }
}
