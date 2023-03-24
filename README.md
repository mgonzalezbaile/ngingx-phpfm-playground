# Nginx & PHP-FPM - Playground
This playground allows you to experiment with the concepts explained in my post [Demystifying Nginx and PHP-FPM for PHP Developers](https://medium.com/p/bba548dd38f9/edit), helping you understand the impact of different configurations on the performance of your PHP application.

## Setup

1. Install [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/).
2. Clone this repository.
3. Run `make xxx` to start the Nginx and PHP-FPM containers, where "xxx" is one of the process manager strategies explained in the post (static, dynamic or ondemand).
4. Visit `http://localhost:8080/` and the message "PHP script completed" should be displayed.

## Configuration
To modify the settings of PHP-FPM and Nginx, edit the `scenarios-config/.env.xxx` file of your chosed process manager strategy. Restart the `make xxx` command.

### Variables
- `PHPFPM_CONTAINER_MEM_LIMIT`: sets a memory limit to the php-fpm container. This parameter allows you to see the behavior of the container when memory is allocated in different ways.

- `PM_STRATEGY`: Set the process manager strategy to static, dynamic or ondemand.
- `PM_MAX_CHILDREN`: Defines the maximum number of worker processes that can be created.
- `PM_MAX_REQUESTS`: Number of total requests a single worker can process after which it's restarted.
- `PM_REQUEST_TERMINATE_TIMEOUT`: Max execution time in seconds before php-fpm terminates a worker.
- `PM_CHILDREN_MEMORY_LIMIT`: Determines the maximum amount of memory a worker can allocate

- `PM_START_SERVERS`: Determines the initial number of worker processes to be created at startup.
- `PM_MIN_SPARE_SERVERS`: Sets the minimum number of idle worker processes that should be always maintained. If the number of idle workers falls below this value, PHP-FPM will create additional processes.
- `PM_MAX_SPARE_SERVERS`: Specifies the maximum number of idle worker processes allowed. If the number of idle workers exceeds this value, PHP-FPM will terminate excess processes.
- `PM_PROCESS_IDLE_TIMEOUT`: Indicates the duration after which idle worker processes will be terminated.

- `PHP_MEM_USED_IN_MB`: Sets a fixed amount of memory used by your php script.
- `PHP_EXECUTION_TIME_IN_SECONDS`: Sets a fixed amount of seconds your php script takes to be processed.

## Load Testing
In order to see how your architecture behaves in a concurrent environment you need to send multiple HTTP requests in parallel. There are different tools in the market for this purpose. You can use `ab` (Apache HTTP server benchmarking tool) to easily send batches of concurrent requests up to a total limit:
```
ab -n 500 -c 100 http://localhost:8080/index.php
```
In the previous example, you are sending batches of 100 simultaneous requests up to 500 requests in total.

## New Testing Scenarios
You can create many configurations for different scenarios in the `scenarios-config` directory.
1. Create a new `.env.xxx` file where "xxx" can be any name.
2. Adjust the values.
3. Add a new entry to the `Makefile` file:
```
xxx:
	docker-compose --env-file scenarios-config/.env.xxx up
```
4. Run `make xxx` to restart Nginx and PHP-FPM with the new config.

## Monitoring
When your containers are up and running, you can visit the built-in status pages provided by Nginx (http://localhost:8080/stub_status) and PHP-FPM (http://localhost:8080/status) to check out their health and performance.

Also, you can monitor the resources usage of the PHP-FPM and Nginx containers by running `docker stats php-fpm` and `docker stats nginx` respectively.
