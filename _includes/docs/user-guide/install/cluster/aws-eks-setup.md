以下为基于AWS EKS平台的不同部署场景脚本：

- [**monolith**](/docs/user-guide/install/{{docsPrefix}}cluster/aws-monolith-setup/) - 仅包含单服务及Amazon RDS for PostgreSQL的简化部署；
- [**microservices**](/docs/user-guide/install/{{docsPrefix}}cluster/aws-microservices-setup/)（推荐）- 以微服务模式部署ThingsBoard，使用Amazon RDS for PostgreSQL、Amazon MSK for Kafka和ElastiCache for Redis；