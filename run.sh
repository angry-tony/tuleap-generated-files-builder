#!/bin/sh

set -e

get_user_group_id_tuleap_volume() {
    stat -c '%u:%g' /tuleap
}

chown "$(get_user_group_id_tuleap_volume)" /output

gosu "$(get_user_group_id_tuleap_volume)" "/run-as-owner.sh" $@
