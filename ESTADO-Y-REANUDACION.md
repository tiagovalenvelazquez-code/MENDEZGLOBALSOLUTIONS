# Evolución por organizaciones — avance conservado

Respaldo del código en curso al 9 de septiembre de 2026. Se conserva por elección del usuario mientras la versión estable se prepara para su primer commit en GitHub.

Esta carpeta NO es la versión estable ni está lista para desplegar. Contiene 160 archivos copiados y comprobados mediante SHA-256 antes de restaurar la base estable en `../mgs-os`. El manifiesto está en `recovery/source-sha256.json`. No se copiaron contraseñas, documentos privados, bases de datos ni node_modules.

## Completado

- Auditoría Phase 0 y correcciones previas conservadas en la versión estable.
- Schema de 40 modelos con Organization, OrganizationMembership y PlatformSettings.
- Migración aditiva `202609090001_tenant_foundation` con backfill MGS, publicId, claves por organización y relaciones compuestas.
- Ensayo de migración sobre una copia: 34 tablas preservadas y trigger de auditoría activo. Resultado en `recovery/migration-rehearsal-results.json`.
- Inicio de cliente tenantDb, identidad y membresía separadas, scoping de servicios/APIs existentes, roles OWNER/ADMIN y acciones adicionales.
- Inicio de helpers de organizaciones, catálogos, branding y API de creación/selección/aceptación.

## Pendiente para reanudar

1. Terminar adaptación de login/logout, administración por membresía y separación de identidad global.
2. Adaptar seed, bootstrap y tests a organización; conservar las cuentas y datos existentes.
3. Implementar selector de workspace y branding configurable en la interfaz.
4. Revisar todos los accesos, transacciones, includes y archivos; comprobar rechazo de accesos entre organizaciones.
5. Resolver TypeScript y lint. Ejecutar unitarios, integración, build, HTTP y pruebas de aislamiento.
6. Aplicar la migración a la base real de trabajo únicamente después de superar los gates, con respaldo y verificación de preservación.

La migración de organizaciones NO fue aplicada a la base local original. La base y los archivos siguen en `../mgs-os/data` y `../mgs-os/private`. Los respaldos previos y huellas están en `../mgs-os/work`; no deben publicarse en GitHub.

Los scripts de `recovery/` son herramientas históricas de la implementación y contienen rutas del workspace original. No los ejecutes sin revisar: algunos regeneran archivos completos. Para continuar, portá de manera controlada este avance a una rama de desarrollo de la versión estable.

El alcance de evolución sigue siendo únicamente Phase 0 + Phase 1. Las fases 2–10 están diferidas.
