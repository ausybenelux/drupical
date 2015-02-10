api = 2
core = 7.x

defaults[projects][subdir] = contrib

projects[] = honeypot
projects[] = securepages
projects[] = securelogin
projects[] = seckit
projects[] = username_enumeration_prevention
projects[] = login_security
projects[] = password_policy

projects[drupal][patch][] = "https://drupal.org/files/issues/drupal7-471970-100-fix-simpletest-https-d7.patch"
projects[drupal][patch][] = "https://drupal.org/files/drupal_https_sessions-961508-214.patch"
projects[drupal][patch][] = "https://drupal.org/files/drupal_https-961508-214-TESTS-ONLY.patch"