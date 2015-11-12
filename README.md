# Sentry + docker-compose + postgre to s3 backup

# What is inside

1.  **Official sentry container**
This container based on the [official Docker image for sentry](https://registry.hub.docker.com/_/sentry/).

2. **Customizable configuration file**. It is extended with customizable 
configuration file `custom.conf.py` where you able to add any of your sentry 
parameters, such as SENTRY_URL_PREFIX, SERVER_EMAIL etc. 
This config file extends default sentry config.

3. **Database backup tool**. This is postgre database backup and restore tool.
This tool allows to setup schedduled cron task to backup database and automatically 
upload it to S3 bucket.

4. **docker-compose**. Everything works from the box.
You don't need to setup anything. Just enter few parameters in 2 files and you
will have Sentry + Postgres + Redis + Celery beat + Celery worker + Backups setup automatically.

# How to use

Git clone ...

Update parameters

## Backup database manually
You need to find docker container `pgbackup` full name or id using `docker ps` command.
It is usually called `dockersentry_pgbackup_1` Then run: 
```
docker exec -it dockersentry_pgbackup_1 ./cron-task.sh
```
And you will have proper database backup done, archived and uploaded to S3 storage.

## Restore database
You need to find url of your database archive in S3 storage and make it temporary public.
For example your url is https://s3-us-west-1.amazonaws.com/your-bucket/sentry-20151110-021500.sql.gz
Then you need to find docker container `pgbackup` full name or id using `docker ps` command.
It is usually called `dockersentry_pgbackup_1` To restore database run: 
```
docker exec -it dockersentry_pgbackup_1 ./restore.sh https://s3-us-west-1.amazonaws.com/your-bucket/sentry-20151110-021500.sql.gz
```