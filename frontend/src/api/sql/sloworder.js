import axios from '../../libs/http';

const sloworderlist = '/api/slowquery/sloworderlist';
export function GetSqlList(params) {
    return axios({
        url: sloworderlist,
        method: 'get',
        params
    });
}

export function GetSqlDetail(id) {
    return axios.get(slowlogget + id);
}

export function SqlUpdateAction(data) {
    return axios({
        url: '/api/slowquery/slowlog/update?id='+ data.id + '&status=' + data.status,
        method: 'get',
        data
    });
}