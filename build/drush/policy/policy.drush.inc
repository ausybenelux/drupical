<?php

/**
 * Implement of drush_hook_COMMAND_validate().
 *
 * Prevent catastrophic braino. Note that this file has to be local to the machine
 * that intitiates sql-sync command.
 */
function drush_policy_sql_sync_validate($source = NULL, $destination = NULL) {

  if (stripos($destination, '.prod') !== FALSE || stripos($destination, '.prerod') !== FALSE) {
    return drush_set_error(dt('Per policy.drush.inc, you may never overwrite the (pre)production database.'));
  }

  if (stripos($source, '.local')) {
    return drush_set_error(dt('Per policy.drush.inc, you may never push your local database.'));
  }

}
