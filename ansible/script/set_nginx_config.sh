#!/usr/bin/env bash

# Copyright (c) 2018 Huawei Technologies Co., Ltd. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

TOP_DIR=$(cd $(dirname "$0") && pwd)
source "$TOP_DIR/util.sh"
source "$TOP_DIR/sdsrc"

cat > /etc/nginx/sites-available/default <<EOF
    server {
        listen 8088 default_server;
        listen [::]:8088 default_server;
        root /var/www/html;
        index index.html index.htm index.nginx-debian.html;
        server_name _;
        location /v3/ {
            proxy_pass http://$HOST_IP/identity/v3/;
        }
        location /v1beta/ {
            proxy_pass http://$HOST_IP:50040/$OPENSDS_VERSION/;
        }
    }
EOF


