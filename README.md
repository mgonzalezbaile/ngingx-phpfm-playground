# Nginx & PHP-FPM - Playground
This playground allows you to experiment with the concepts explained in my post [Demystifying Nginx and PHP-FPM for PHP Developers](https://medium.com/p/bba548dd38f9/edit), helping you understand the impact of different configurations on the performance of your PHP application.

## Setup

1. Install [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/).
2. Clone this repository.
3. Run `make default` to start the Nginx and PHP-FPM containers.
4. Visit `http://localhost:8080/` and the message "PHP script completed" should be displayed.

## Configuration
To modify the settings of PHP-FPM and Nginx, edit the `scenarios-config/.env.default` file. Restart the `make default` command.

### Variables
- PHPFPM_CONTAINER_MEM_LIMIT: sets a memory limit to the php-fpm container. This will allow you to see the behavior of php-fpm when memory is exhausted due to the memory usage of many workers running in parallel.

- `PM_STRATEGY`: set the process manager strategy as explained in the Medium's post to static, dynamic or ondemand.
- `PM_MAX_CHILDREN`: maximum number of workers.
- `PM_MAX_REQUESTS`: Number of total requests a single worker can process after which it's restarted.
- `PM_REQUEST_TERMINATE_TIMEOUT`: Max execution time in seconds before php-fpm terminates a worker.


- `PHP_MEM_USED_IN_MB`: set a fixed amount of memory used by your php script.
- `PHP_EXECUTION_TIME_IN_SECONDS`: set a fixed amount of seconds your php script takes to be processed.


## Testing Scenarios
You can create many configurations for different scenarios in the `scenarios-config` directory.
1. Create a new `.env.xxx` file where "xxx" can be any name.
2. Adjust the values.
3. Add a new entry to the `Makefile` file:
```
xxx:
	docker-compose --env-file scenarios-config/.env.xxx up
```
4. Run `Makefile xxx` to restart Nginx and PHP-FPM with the new config.

## Monitoring
