import axios from '../../libs/http';

const slowmyorderlist = '/api/slowquery/slowmyorderlist';

export function GetSqlList(params) {
    return axios({
        url: slowmyorderlist,
        method: 'get',
        params
    });
}

export function Putdata(data){
	return axios({
        url: slowmyorderlist + '/',
        method: 'post',
        data: data
    });
}

export function GetSqlDetail(id) {
    return axios.get(slowlogget + id);
}

export function SqlAction(id, action) {
    return axios.get(inceptions + id + '/' + action);
}