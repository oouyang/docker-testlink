#!/bin/bash

rm -rf /app/testlink/install

echo "" >> /app/testlink/config.inc.php
echo "\$tlCfg->config_check_warning_mode = 'SILENT';" >> /app/testlink/config.inc.php