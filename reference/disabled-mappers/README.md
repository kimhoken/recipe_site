# 임시 보관 Mapper

현재 프로젝트에 없는 DTO 및 예전 DB 구조를 참조하여 자동 로딩 경로 밖에 보관했습니다.
- recipe_mapper.xml: 이전 프로젝트의 일반 레시피 Mapper
- AdminRecipeManagement.xml: 관리자 레시피 쿼리 6개

복구 시 타입 별칭과 테이블 구조를 확인하고 기존 namespace 내 쿼리 ID가 중복되지 않도록 병합하세요.
