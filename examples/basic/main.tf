provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "mailcow_key" {
  key_name   = "mailcow_key"
  public_key = "ssh-rsa AAAAB3Nz...."
}

module "mailcow" {
  source = "./../.."

  key_name = aws_key_pair.mailcow_key.id
  conf     = <<-EOF
    MAILCOW_HOSTNAME=mx.example.com
    MAILCOW_PASS_SCHEME=BLF-CRYPT
    DBNAME=mailcow
    DBUSER=mailcow
    DBPASS=randompassword
    DBROOT=randomrootpassword
    HTTP_PORT=80
    HTTP_BIND=0.0.0.0
    HTTPS_PORT=443
    HTTPS_BIND=0.0.0.0
    SMTP_PORT=25
    SMTPS_PORT=465
    SUBMISSION_PORT=587
    IMAP_PORT=143
    IMAPS_PORT=993
    POP_PORT=110
    POPS_PORT=995
    SIEVE_PORT=4190
    DOVEADM_PORT=127.0.0.1:19991
    SQL_PORT=127.0.0.1:13306
    SOLR_PORT=127.0.0.1:18983
    REDIS_PORT=127.0.0.1:7654
    TZ=Vancouver/America
    COMPOSE_PROJECT_NAME=mailcowdockerized
    ACL_ANYONE=disallow
    MAILDIR_GC_TIME=7200
    ADDITIONAL_SAN=
    SKIP_LETS_ENCRYPT=n
    ENABLE_SSL_SNI=n
    SKIP_IP_CHECK=n
    SKIP_HTTP_VERIFICATION=n
    SKIP_CLAMD=y
    SKIP_SOGO=y
    SKIP_SOLR=y
    SOLR_HEAP=1024
    ALLOW_ADMIN_EMAIL_LOGIN=n
    USE_WATCHDOG=y
    WATCHDOG_NOTIFY_BAN=n
    WATCHDOG_EXTERNAL_CHECKS=n
    IPV4_NETWORK=172.22.1
    IPV6_NETWORK=fd4d:6169:6c63:6f77::/64
    MAILDIR_SUB=Maildir
    SOGO_EXPIRE_SESSION=480
    DOVECOT_MASTER_USER=
    DOVECOT_MASTER_PASS= 
  EOF
}
