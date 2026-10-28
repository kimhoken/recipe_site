(() => {
    const rows = Array.from(document.querySelectorAll('.community-post'));
    const filters = document.querySelectorAll('.community-filters button');
    const search = document.getElementById('community-search');
    const pagination = document.querySelector('.community-pagination');
    let category = 'ALL';
    let page = 1;
    const pageSize = 10;
    function render() {
        const keyword = search.value.trim().toLocaleLowerCase();
        const matches = rows.filter(row => (category === 'ALL' || row.dataset.category === category) && row.querySelector('.community-post-title').textContent.toLocaleLowerCase().includes(keyword));
        const count = Math.ceil(matches.length / pageSize);
        page = Math.max(1, Math.min(page, count));
        rows.forEach(row => { row.hidden = true; });
        matches.slice((page - 1) * pageSize, page * pageSize).forEach(row => { row.hidden = false; });
        const empty = document.getElementById('community-empty');
        empty.hidden = matches.length > 0;
        empty.textContent = rows.length ? '조건에 맞는 게시글이 없습니다.' : '아직 등록된 게시글이 없습니다. 첫 이야기를 나눠보세요.';
        document.getElementById('community-result').textContent = '게시글 ' + matches.length + '개';
        pagination.replaceChildren();
        function addButton(label, target) {
            const button = document.createElement('button');
            button.type = 'button';
            button.textContent = label;
            button.setAttribute('aria-label', target + '페이지');
            if (target === page) button.setAttribute('aria-current', 'page');
            button.addEventListener('click', () => { page = target; render(); });
            pagination.appendChild(button);
        }
        const start = Math.max(1, Math.min(page - 2, count - 4));
        if (page > 1) addButton('‹', page - 1);
        for (let n = start; n <= Math.min(count, start + 4); n++) addButton(String(n), n);
        if (page < count) addButton('›', page + 1);
    }
    filters.forEach(button => button.addEventListener('click', () => {
        category = button.dataset.category;
        page = 1;
        filters.forEach(filter => {
            filter.classList.toggle('is-active', filter === button);
            filter.setAttribute('aria-pressed', String(filter === button));
        });
        render();
    }));
    search.addEventListener('input', () => { page = 1; render(); });
    const toggle = document.querySelector('.community-notice-toggle');
    toggle.hidden = document.querySelectorAll('.community-notice-row').length <= 2;
    toggle.addEventListener('click', () => {
        const expanded = document.querySelector('.community-notices').classList.toggle('is-expanded');
        toggle.setAttribute('aria-expanded', String(expanded));
        toggle.textContent = expanded ? '접기' : '전체보기';
    });
    render();
})();
