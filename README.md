# repro-13269

- `yarn`
- check .env and add a valid connection string
- `yarn prisma migrate dev`

```
Applying migration `20220510114355_baseline`
Error: P1014

The underlying table for model `_prisma_migrations` does not exist.
```
