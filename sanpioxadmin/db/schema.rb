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

ActiveRecord::Schema.define(version: 20161005023152) do

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

  create_table "cursos", force: :cascade do |t|
    t.string   "curso",       limit: 255
    t.string   "especalidad", limit: 255
    t.string   "seccion",     limit: 255
    t.integer  "cuota",       limit: 4
    t.integer  "matricula",   limit: 4
    t.integer  "year",        limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "matriculacions", force: :cascade do |t|
    t.integer  "alumno_id",  limit: 4
    t.integer  "curso_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "matriculacions", ["alumno_id"], name: "matriculacions_alumno_id_fk", using: :btree
  add_index "matriculacions", ["curso_id"], name: "matriculacions_curso_id_fk", using: :btree

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

