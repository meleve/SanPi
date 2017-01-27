# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170126193309) do

  create_table "alumnos", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.string   "apellido",    limit: 255
    t.string   "ci",          limit: 255
    t.date     "fechanac"
    t.string   "lugarnac",    limit: 255
    t.string   "domicilio",   limit: 255
    t.string   "nombrema",    limit: 255
    t.string   "profesionma", limit: 255
    t.integer  "cel",         limit: 4
    t.string   "nombrepa",    limit: 255
    t.string   "porfesionpa", limit: 255
    t.integer  "celpa",       limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "cajas", force: :cascade do |t|
    t.integer  "usuario_id",    limit: 4
    t.datetime "fechaApertura"
    t.datetime "fechaCierre"
    t.integer  "apertura",      limit: 4
    t.integer  "cierre",        limit: 4
    t.integer  "entrada",       limit: 4
    t.integer  "salida",        limit: 4
    t.boolean  "estado"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "cajas", ["usuario_id"], name: "cajas_usuario_id_fk", using: :btree

  create_table "cierre_cajas", force: :cascade do |t|
    t.integer  "usuario_id", limit: 4
    t.datetime "fApertura"
    t.datetime "fCierre"
    t.integer  "apertura",   limit: 4
    t.integer  "cierre",     limit: 4
    t.integer  "entrada",    limit: 4
    t.integer  "salida",     limit: 4
    t.boolean  "estado"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "cta_ctes", force: :cascade do |t|
    t.integer  "matriculacion_id", limit: 4
    t.integer  "nro_cta_cte",      limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "montoimporte",     limit: 4
  end

  add_index "cta_ctes", ["matriculacion_id"], name: "cta_ctes_matriculacion_id_fk", using: :btree
  add_index "cta_ctes", ["montoimporte"], name: "index_cta_ctes_on_montoimporte", using: :btree

  create_table "cursos", force: :cascade do |t|
    t.string   "curso",        limit: 255
    t.string   "especialidad", limit: 255
    t.string   "seccion",      limit: 255
    t.integer  "year",         limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "montototal",   limit: 4
  end

  add_index "cursos", ["montototal"], name: "index_cursos_on_montototal", using: :btree

  create_table "detalle_cursos", force: :cascade do |t|
    t.integer  "curso_id",     limit: 4
    t.integer  "cantidad",     limit: 4
    t.string   "descripcion",  limit: 255
    t.date     "vencimiento"
    t.integer  "importe",      limit: 4
    t.integer  "totalimporte", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "detalle_cursos", ["curso_id"], name: "detalle_cursos_curso_id_fk", using: :btree

  create_table "detalle_facturas", force: :cascade do |t|
    t.integer  "factura_id",       limit: 4
    t.integer  "matriculacion_id", limit: 4
    t.integer  "nro_mov",          limit: 4
    t.string   "descripcion",      limit: 255
    t.integer  "importe",          limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "detalle_facturas", ["factura_id"], name: "detalle_facturas_factura_id_fk", using: :btree
  add_index "detalle_facturas", ["matriculacion_id"], name: "detalle_facturas_matriculacion_id_fk", using: :btree

  create_table "facturas", force: :cascade do |t|
    t.integer  "usuario_id", limit: 4
    t.integer  "alumno_id",  limit: 4
    t.integer  "nro_fac",    limit: 4
    t.integer  "total",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "facturas", ["alumno_id"], name: "facturas_alumno_id_fk", using: :btree
  add_index "facturas", ["usuario_id"], name: "facturas_usuario_id_fk", using: :btree

  create_table "matriculacions", force: :cascade do |t|
    t.integer  "alumno_id",  limit: 4
    t.integer  "curso_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "matriculacions", ["alumno_id"], name: "matriculacions_alumno_id_fk", using: :btree
  add_index "matriculacions", ["curso_id"], name: "matriculacions_curso_id_fk", using: :btree

  create_table "mov_cajas", force: :cascade do |t|
    t.integer  "caja_id",    limit: 4
    t.string   "concepto",   limit: 255
    t.integer  "ingreso",    limit: 4
    t.integer  "egreso",     limit: 4
    t.integer  "saldo",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "mov_cajas", ["caja_id"], name: "mov_cajas_caja_id_fk", using: :btree

  create_table "movimientos", force: :cascade do |t|
    t.integer  "cta_cte_id",   limit: 4
    t.integer  "nro_mov",      limit: 4
    t.string   "descripcion",  limit: 255
    t.integer  "importe",      limit: 4
    t.boolean  "estado"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "totalimporte", limit: 4
  end

  add_index "movimientos", ["cta_cte_id"], name: "movimientos_cta_cte_id_fk", using: :btree
  add_index "movimientos", ["totalimporte"], name: "index_movimientos_on_totalimporte", using: :btree

  create_table "pagos_servicios", force: :cascade do |t|
    t.string   "servicio",   limit: 255
    t.integer  "monto",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "productos", force: :cascade do |t|
    t.string   "nombreproduct", limit: 255
    t.string   "descripcion",   limit: 255
    t.integer  "cantidad",      limit: 4
    t.integer  "precio",        limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree

