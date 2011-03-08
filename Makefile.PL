use inc::Module::Install;

name        'WikiText';
all_from    'lib/WikiText.pm';
readme_from;
manifest_skip;
version_check;
ack_xxx;

requires    perl => '5.6.1';

use_test_base;

WriteAll;
