-- نسخي كل هذا الكود وضعيه في "SQL Editor" داخل Supabase
-- ملاحظة: لو سبق وعملتي هذا الجدول من قبل، شغّلي هذا السطر أولاً لحذف القديم:
-- drop table if exists products;

create table products (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  category text not null,
  description text,
  image text,
  variants jsonb not null,
  created_at timestamp with time zone default now()
);

-- السماح للجميع بقراءة المنتجات (الموقع العام يحتاج هذا)
alter table products enable row level security;

create policy "Anyone can view products"
  on products for select
  using (true);

create policy "Anyone can insert products"
  on products for insert
  with check (true);

create policy "Anyone can update products"
  on products for update
  using (true);

create policy "Anyone can delete products"
  on products for delete
  using (true);

-- إضافة المنتجات الثلاثة الحالية كبداية
insert into products (name, category, description, image, variants) values
(
  'بودرة Enchanteur Perfumed Talc',
  'عناية بالبشرة',
  'بودرة معطرة فاخرة بروائح Romantic وCharming وEnticing، ملمس حريري ناعم وانتعاش يدوم طوال اليوم.',
  null,
  '[{"label":"125 مل","price":150,"oldPrice":185},{"label":"250 مل","price":225,"oldPrice":265}]'::jsonb
),
(
  'عطر Amaran Qamarain For Him',
  'عطور',
  'عطر عربي فاخر للرجال، نفحات أناناس وبرغموت مع قاعدة خشبية من الأوكموس، ثبات طويل وصناعة دبي.',
  null,
  '[{"label":"100 مل","price":1475,"oldPrice":1650}]'::jsonb
),
(
  'بودرة تثبيت SHEGLAM Blur In A Bottle',
  'مكياج',
  'بودرة تثبيت المكياج بتأثير Blur لإخفاء المسام والعيوب، فينيش مطفي ناعم بدون تكتل، متوفرة بلون Translucent وBanana.',
  null,
  '[{"label":"الحجم العادي","price":345,"oldPrice":420}]'::jsonb
);
