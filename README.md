# Mendez Global Solutions OS

Aplicación de gestión para operaciones de comercio internacional. Integra relaciones comerciales, commodities, documentación, compliance, logística y finanzas en un mismo workspace.

Esta entrega corresponde a la **versión estable para una organización**. La evolución hacia múltiples organizaciones está conservada por separado y no forma parte de este primer commit. Los módulos, las rutas, los códigos MGS y las reglas de negocio de la versión estable se mantienen.

## Funcionalidades

- CRM, empresas, contactos, leads, buyers, sellers y partners.
- Productos, categorías, demandas, ofertas y matching con criterios explicables.
- Operaciones TRADING/BROKERAGE, líneas de productos y etapas con validaciones.
- KYC, evidencia documental, contratos y descargas de archivos privados.
- Logística, movimientos financieros, P&L por moneda y comisiones.
- Dashboard, búsqueda transversal, tareas, notificaciones y reportes CSV, XLSX y PDF.
- Usuarios, 14 roles, permisos en el servidor y auditoría inmutable.
- Formularios validados, control de versiones de registros, tablas, tarjetas, kanban, calendario y modo oscuro.

Los datos demo son ficticios. Las integraciones de email, mensajería, screening, transportistas y APIs de mercado todavía requieren conexión; no ejecutan acciones externas en esta versión.

## Stack

Next.js 16.3.4, React 19.2.8 y TypeScript 5.9.3. Prisma 6.19 y PostgreSQL, con PGlite persistente para la demostración local. Validaciones Zod, cálculos monetarios Decimal.js, reportes ExcelJS/jsPDF y pruebas Vitest.

El runtime de la aplicación es **Node.js**. Se conservan archivos de la plantilla original Sites/Vite como referencia, pero los comandos de desarrollo y compilación usan Next.js. No hay un despliegue público configurado.

## Inicio local

Requisitos: Node.js 22.13 o superior, Git y pnpm 11.19.0. Entorno comprobado: Windows, Node.js 24.19.0 y pnpm 11.19.0.

Desde la carpeta del proyecto:

```powershell
npm install -g pnpm@11.19.0
pnpm install --frozen-lockfile
pnpm demo
```

Abrí [http://127.0.0.1:3000](http://127.0.0.1:3000).

En el primer inicio, `pnpm demo` crea `.env` con una contraseña aleatoria, inicia PostgreSQL local, aplica la migración, inserta los datos ficticios y arranca Next.js. El usuario es `admin@mgs-demo.test`; la contraseña se guarda en `ACCESO-LOCAL.txt`, **en la carpeta superior al proyecto**. Ese archivo y `.env` no se incluyen en Git.

Si ya existe `.env`, se conserva. Si lo creaste manualmente desde `.env.example`, completá `DEMO_ADMIN_PASSWORD` con una contraseña propia de al menos 12 caracteres antes del primer seed. El seed conserva los datos demo previamente inicializados.

También podés ejecutar `./Start-MGS.ps1` desde PowerShell. Para detener los servicios iniciados por `pnpm demo`, usá `Ctrl+C` en esa terminal.

La base local persiste en `data/postgres` y los documentos en `private/uploads`. PostgreSQL local usa el puerto 54329 y la aplicación el 3000, ambos en la interfaz local. Conservá esas carpetas para mantener tus datos; no forman parte del código versionado.

## Configuración

`.env.example` contiene ejemplos locales y campos vacíos para credenciales. La URL de PGlite incluye valores descartables de desarrollo, no credenciales de un servidor privado.

| Variable | Uso |
| --- | --- |
| `DATABASE_URL` | Conexión PostgreSQL del entorno actual |
| `APP_URL` | Origen exacto de la aplicación para validar las solicitudes |
| `APP_ENV` | `development` o `production`; controla cookies seguras y HSTS |
| `DEMO_DATA` | Habilita explícitamente la carga de datos ficticios |
| `DEMO_ADMIN_EMAIL`, `DEMO_ADMIN_PASSWORD` | Cuenta inicial de demostración |
| `STORAGE_DIR` | Directorio privado de archivos |
| `LOCAL_PG_PORT`, `LOCAL_PG_DIR` | Servicio PostgreSQL local de desarrollo |
| `SESSION_HOURS`, `MAX_UPLOAD_MB` | Duración de sesiones y límite de archivos |
| `TRUST_PROXY` | Usar cabeceras de IP solo detrás de un proxy configurado |
| `BOOTSTRAP_ADMIN_*` | Administrador inicial de un entorno real vacío |
| `POSTGRES_PASSWORD` | Contraseña privada del servicio Docker opcional |

No uses prefijos `NEXT_PUBLIC_` para contraseñas, tokens o conexiones privadas.

## Comandos

| Comando | Función |
| --- | --- |
| `pnpm demo` | Iniciar la demostración persistente completa |
| `pnpm dev` | Iniciar solo Next.js; requiere base configurada |
| `pnpm db:start` | Iniciar solo el PostgreSQL local |
| `pnpm db:generate` | Regenerar Prisma Client |
| `pnpm db:migrate` | Aplicar migraciones pendientes, sin reset |
| `pnpm db:seed` | Cargar el seed ficticio explícitamente habilitado |
| `pnpm db:bootstrap` | Crear administrador y catálogos en un entorno real vacío |
| `pnpm typecheck` | Comprobar TypeScript |
| `pnpm lint` | Revisar errores de código |
| `pnpm test` | Ejecutar las pruebas unitarias |
| `pnpm test:integration` | Probar reglas y persistencia en una base aislada en memoria |
| `pnpm build` | Generar Prisma Client y compilar Next.js para producción |
| `pnpm start` | Servir la compilación de producción en localhost |
| `pnpm test:http` | Probar la aplicación demo en ejecución, usando su `.env` |
| `pnpm check:secrets` | Revisar los archivos preparados en el índice de Git |

La integración usa el puerto 54330 y `work/test-uploads`; no resetea la base local de la aplicación. Las pruebas HTTP requieren la demostración inicializada y no deben dirigirse a una base real de producción.

## Estructura

```text
app/                    Páginas Next.js y rutas API
components/mgs/         Interfaz del workspace y módulos
components/auth/        Inicio de sesión
components/ui/          Componentes reutilizables
lib/auth/               Sesiones, contraseñas y permisos
lib/domain/             Catálogo de módulos, validaciones y cálculos
lib/services/           Reglas, registros, auditoría, archivos y reportes
lib/db/                 Cliente Prisma y acceso a datos
prisma/schema.prisma    Modelo relacional estable: 37 modelos
prisma/migrations/      Migración SQL inicial versionada
prisma/seed.ts          Datos ficticios reproducibles
scripts/                Inicio, bootstrap y verificaciones
tests/                  Pruebas unitarias, de integración y HTTP
docs/                   Arquitectura, auditoría y guía GitHub
public/                 Recursos estáticos públicos
```

`node_modules`, `.next`, `.env`, datos, documentos privados, respaldos, logs y estado local de hosting quedan fuera de Git. `pnpm-lock.yaml` sí se versiona para fijar las dependencias resueltas.

## Entorno real y despliegue

Usá una base PostgreSQL separada, almacenamiento privado persistente y un servidor Node detrás de HTTPS. Configurá `DEMO_DATA=false`, `APP_ENV=production`, `APP_URL` con el origen HTTPS real y una `DATABASE_URL` privada. En una base vacía, configurá `BOOTSTRAP_ADMIN_EMAIL` y `BOOTSTRAP_ADMIN_PASSWORD` de al menos 14 caracteres, y ejecutá:

```powershell
pnpm db:generate
pnpm db:migrate
pnpm db:bootstrap
pnpm build
pnpm start
```

El bootstrap se niega a modificar usuarios existentes. Retirá la contraseña de bootstrap del entorno después de utilizarla. Aplicá migraciones solo contra la base prevista y mantené respaldos independientes del repositorio.

Se incluyen `Dockerfile` y `compose.yaml` como base de despliegue; Docker y un despliegue público no fueron validados en esta máquina. Esta entrega no incluye aislamiento entre organizaciones, recuperación por email, MFA ni servicios externos conectados.

## GitHub y documentación

- [Vincular y subir a MENDEZGLOBALSOLUTIONS](docs/GITHUB.md)
- [Revisión de secretos y archivos privados](docs/SECURITY.md)
- [Verificación de la entrega estable](docs/GITHUB_READINESS.md)
- [Arquitectura y decisiones existentes](docs/IMPLEMENTATION.md)
- [Auditoría técnica de la base](docs/TECHNICAL_BASELINE.md)
- [Validaciones de Phase 0](docs/PHASE-0.md)

La propiedad del código corresponde a su titular. Esta preparación no agrega una licencia de software libre.
