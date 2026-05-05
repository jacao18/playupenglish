-- ============================================================
-- PlayUp English — Supabase Setup para Atividades
-- Execute este SQL no SQL Editor do Supabase Dashboard
-- ============================================================


-- 1. TABELA DE ATIVIDADES
-- ============================================================
CREATE TABLE IF NOT EXISTS activities (
  id          UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  title       TEXT        NOT NULL,
  description TEXT,
  link        TEXT,
  image_url   TEXT        NOT NULL,
  categories  TEXT[]      NOT NULL DEFAULT '{}',
  labels      TEXT[]               DEFAULT '{}',
  created_by  UUID        REFERENCES auth.users(id) ON DELETE SET NULL,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Se a tabela já existia, rode só os ALTERs necessários:
-- ALTER TABLE activities ADD COLUMN IF NOT EXISTS description TEXT;
-- ALTER TABLE activities ADD COLUMN IF NOT EXISTS labels TEXT[] DEFAULT '{}';
-- ALTER TABLE activities ALTER COLUMN link DROP NOT NULL;


-- 2. ROW LEVEL SECURITY (RLS)
-- ============================================================
ALTER TABLE activities ENABLE ROW LEVEL SECURITY;

-- Qualquer pessoa pode ler
CREATE POLICY "activities_select_public"
  ON activities FOR SELECT
  USING (true);

-- Só os admins podem inserir
CREATE POLICY "activities_insert_admin"
  ON activities FOR INSERT
  WITH CHECK (
    auth.email() IN ('andressa.larsen@acad.pucrs.br', 'j_kauer@hotmail.com')
  );

-- Só os admins podem atualizar
CREATE POLICY "activities_update_admin"
  ON activities FOR UPDATE
  USING (
    auth.email() IN ('andressa.larsen@acad.pucrs.br', 'j_kauer@hotmail.com')
  );

-- Só os admins podem deletar
CREATE POLICY "activities_delete_admin"
  ON activities FOR DELETE
  USING (
    auth.email() IN ('andressa.larsen@acad.pucrs.br', 'j_kauer@hotmail.com')
  );


-- 3. STORAGE BUCKET PARA IMAGENS
-- ============================================================
-- Execute no SQL Editor do Supabase:

INSERT INTO storage.buckets (id, name, public)
VALUES ('activity-images', 'activity-images', true)
ON CONFLICT (id) DO NOTHING;

-- Política de leitura pública para as imagens
CREATE POLICY "activity_images_public_read"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'activity-images');

-- Só admins podem fazer upload
CREATE POLICY "activity_images_admin_insert"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'activity-images'
    AND auth.email() IN ('andressa.larsen@acad.pucrs.br', 'j_kauer@hotmail.com')
  );

-- Só admins podem deletar imagens
CREATE POLICY "activity_images_admin_delete"
  ON storage.objects FOR DELETE
  USING (
    bucket_id = 'activity-images'
    AND auth.email() IN ('andressa.larsen@acad.pucrs.br', 'j_kauer@hotmail.com')
  );


-- 4. TABELA DE SLIDES DO CARROSSEL
-- ============================================================
CREATE TABLE IF NOT EXISTS carousel_slides (
  id          UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  title       TEXT        NOT NULL,
  tag         TEXT,
  description TEXT,
  image_url   TEXT,
  bg_color    TEXT        DEFAULT '#1F3E7D',
  btn_text    TEXT,
  btn_link    TEXT,
  sort_order  INT         DEFAULT 0,
  created_at  TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE carousel_slides ENABLE ROW LEVEL SECURITY;

-- Qualquer pessoa pode ler os slides
CREATE POLICY "carousel_select_public"
  ON carousel_slides FOR SELECT
  USING (true);

-- Só admins podem inserir
CREATE POLICY "carousel_insert_admin"
  ON carousel_slides FOR INSERT
  WITH CHECK (
    auth.email() IN ('andressa.larsen@acad.pucrs.br', 'j_kauer@hotmail.com')
  );

-- Só admins podem atualizar
CREATE POLICY "carousel_update_admin"
  ON carousel_slides FOR UPDATE
  USING (
    auth.email() IN ('andressa.larsen@acad.pucrs.br', 'j_kauer@hotmail.com')
  );

-- Só admins podem deletar
CREATE POLICY "carousel_delete_admin"
  ON carousel_slides FOR DELETE
  USING (
    auth.email() IN ('andressa.larsen@acad.pucrs.br', 'j_kauer@hotmail.com')
  );
